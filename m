Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965105AbWFTGze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbWFTGze (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 02:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbWFTGze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 02:55:34 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:25668 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965103AbWFTGzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 02:55:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IcGL+CoVBsTraf7m0AdKU2cHlilk7KKHTTpostHE9HVmpAvv0S2F8O51+KBOdNEfTTK6POSqUDegQWaSw5anRkAumcZg0ZuWlSsEvyaPTEhm6mtE55Mk2L1S9+UuMtv1vbWfXUIVftQV/uc9lAwkwN4zv+Ezhp/c93VodMi1MY0=
Message-ID: <7fc623d50606192355l799ea043hc4eacb190e6be1ce@mail.gmail.com>
Date: Tue, 20 Jun 2006 14:55:32 +0800
From: "Heng Du" <debbiehow315@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: E1000 zero copy
Cc: linux-net@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I want to know if there is an existing patch to e1000 network driver
to enable zero copy.
If so, can you share me with it?
If not, is it accepable if I submit a patch?
Many thanks

Regards,
-Debbie
