Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVBOX1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVBOX1e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 18:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVBOX1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 18:27:33 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:54850 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261947AbVBOX10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 18:27:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=f/0ylfDiNlS14RcKlXol4MfGwmtf2z/tc2c170FmRr63LNfDhhQjk5ftlV65BRrGTY7K4PaLqgc6aFO14113FNyxWCTYV12Z43Ttt8sjtHOQ07zOygkmIPqOB+OmFMf6oxLAcQmFjT7EJnve2bybDBKbsZhzzeOmBR/dcce49DY=
Message-ID: <90f56e480502151527696ef315@mail.gmail.com>
Date: Tue, 15 Feb 2005 15:27:25 -0800
From: Ajay Patel <patela@gmail.com>
Reply-To: Ajay Patel <patela@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 on PowerMac9,1 G5 Fan problem
Cc: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a single processor PowerMac G5 where
the model property is PowerMac9,1.
I do have therm_pm72 and I2C_keywest option
enabled in my config. Still fans are always on.

Any thermal control driver patch available for this newer G5?

Thanks in advance for your help.
Aj
