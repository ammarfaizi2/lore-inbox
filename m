Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279932AbRJ3MCe>; Tue, 30 Oct 2001 07:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279933AbRJ3MCY>; Tue, 30 Oct 2001 07:02:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10002 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279932AbRJ3MCQ>; Tue, 30 Oct 2001 07:02:16 -0500
Subject: Re: Still having problems with eepro100
To: jo_ni@telia.com (Johan)
Date: Tue, 30 Oct 2001 12:09:38 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011030123927.74e26501.jo_ni@telia.com> from "Johan" at Oct 30, 2001 12:39:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yXi6-0006Hd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am using the eepro100 drivers with my 100/10 card running in
> 10mbit and it works in windows.
> 
> I have been trying all new kernels + the ac patches but nothing
> seems to work. The fun thing is that I only gets this problem
> when I am running XFree, is this just a weird coincidence?

Possibly not. 

I have one problem box where you have to disable the kernel ACPI stuff but
the XFree case is a new one to me
