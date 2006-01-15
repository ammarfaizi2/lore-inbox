Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWAOS5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWAOS5J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 13:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWAOS5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 13:57:09 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:49203 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750784AbWAOS5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 13:57:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=ZGJxJtnbkEqzXgStyrylKAUuv1zb8xvSAf+mEtz8nuoA6jJr/i/IVU/egDrglW9R+dhwO0IRzT2f98oWXtzRs8W1CSuO62q/Z8wTek4C+xRmV1JDh1fuBKwoUrqPVlv1ZV93NidT9PlpJMmVfMPbxuIrO8ATyhWoMjQxRln9EVg=
Subject: string to inode conversion
From: "pablo.ferlop@gmail.com" <pablo.ferlop@gmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 15 Jan 2006 19:57:10 +0100
Message-Id: <1137351430.11284.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I was wondering how I can get from a string with a path like "/home" or
"/lib/libc-2.3.5.so" a struct inode.

Thanks for your help.


