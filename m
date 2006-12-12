Return-Path: <linux-kernel-owner+w=401wt.eu-S1751362AbWLLOGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWLLOGh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 09:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWLLOGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 09:06:37 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:49759 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751362AbWLLOGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 09:06:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IbB6J+5juJsKmknYjCA2uJ6FzKugGKMJ5oOb46ymwwvIG4Y2shVhcg2LUlDIVdekwq0oT1RXYGEZtJv9qt5Qzolh+kVqglUK/2NlVwAAOW6DvIOCnbiY07qbrXV2VxJwLZMAA6rId9pWWDaVnZP+4upP/VTS4hw++47RTWZfJOk=
Message-ID: <aa5953d60612120606g8c59542seaa440b7b0404ff5@mail.gmail.com>
Date: Tue, 12 Dec 2006 19:36:35 +0530
From: "Jaswinder Singh" <jaswinderrajput@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Support 2.4 modules features in 2.6
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I want to support old 2.4 modules features in 2.6 kernel modules:-
1. no kernel source tree is required to build modules.
2. support modular plugins.
3. modules EXPORT by default.

Is any patch available, or somebody working on it ?

Thank you,

Jaswinder Singh.
