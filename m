Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUDPNt6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 09:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUDPNt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 09:49:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2453 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263167AbUDPNt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 09:49:56 -0400
Date: Fri, 16 Apr 2004 15:49:55 +0200
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Documentation/devices.txt missng information addition suggestion
Message-ID: <20040416134955.GD6879@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I tried to determine which line of make menuconfig should be ticked up
to get /dev/parport0.

devices.txt say
 99 char        Raw parallel ports
                  0 = /dev/parport0     First parallel port
                  1 = /dev/parport1     Second parallel port

parport.txt doesn't contain the word "raw". I also didn't find
anything that would discuss the problematics of raw parallel ports
in parport.txt

Suggestion #1: add information about raw parport access into parport.txt
Suggestion #2: add information to which make menuconfig entry the
raw parallel ports correspond into devices.txt file.


Cl<

