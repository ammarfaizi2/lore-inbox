Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVGPALT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVGPALT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 20:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVGPALT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 20:11:19 -0400
Received: from ribosome.natur.cuni.cz ([195.113.57.20]:54721 "EHLO
	ribosome.natur.cuni.cz") by vger.kernel.org with ESMTP
	id S262014AbVGPALS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 20:11:18 -0400
Date: Sat, 16 Jul 2005 02:09:47 +0200
From: Martin Mokrejs <mmokrejs@ribosome.natur.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: init 0 stopped working
Message-ID: <20050716000947.GA24094@ribosome.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I used to shutdown my P4 machine based on ASUS P4C800E-Deluxe
with simple "init 0" command. That somehow broke between 2.6.12-rc6-git2
and 2.6.13-rc1. The machines makes the sound like shutdown but it
immediately turns the power on again. I used acpi and the kernel
configs should be almost identical in all cases, as I just recopy
previously used .config and run "make oldconfig".

  Any clues? I still happens even with 2.6.13-rc3-git2.
Please Cc: me in replies.
Martin
