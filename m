Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSHJGY0>; Sat, 10 Aug 2002 02:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316712AbSHJGY0>; Sat, 10 Aug 2002 02:24:26 -0400
Received: from [203.199.83.245] ([203.199.83.245]:49541 "HELO
	mailweb33.rediffmail.com") by vger.kernel.org with SMTP
	id <S316682AbSHJGYZ>; Sat, 10 Aug 2002 02:24:25 -0400
Date: 10 Aug 2002 06:27:50 -0000
Message-ID: <20020810062750.15683.qmail@mailweb33.rediffmail.com>
MIME-Version: 1.0
From: "Karan  Misra" <k_i_d_o@rediffmail.com>
Reply-To: "Karan  Misra" <k_i_d_o@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: Swapping problems !
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am hving a peculiar problem:

When ever I am loading a few applications (XEmacs, KDE, gcc, 
VMWare) on my 256M machine(520M swap), my system goes for a 
run...

What exactly happens is the Harddisk just thrases and my computer 
slows down to a crawl. Only a reboot solves the problem.

However I tried something like:

swapoff /dev/hda2; swapon /dev/hda2

and the problem stopped... I run ext3 on /boot & /

Anyway can HELP me...


__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/

