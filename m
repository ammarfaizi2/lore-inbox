Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTDRXWp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 19:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbTDRXWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 19:22:45 -0400
Received: from nika.frontier.iarc.uaf.edu ([137.229.94.16]:1920 "EHLO
	nika.frontier.iarc.uaf.edu") by vger.kernel.org with ESMTP
	id S263299AbTDRXWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 19:22:45 -0400
Date: Fri, 18 Apr 2003 15:34:42 -0800
From: Christopher Swingley <cswingle@iarc.uaf.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67 oops upon removing USB flash drive
Message-ID: <20030418233442.GB831@iarc.uaf.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030418232756.GA831@iarc.uaf.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030418232756.GA831@iarc.uaf.edu>
X-gpg-fingerprint: B96C 58DC 0643 F8FE C9D0  8F55 1542 1A4F 0698 252E
X-gpg-key: [http://www.frontier.iarc.uaf.edu/~cswingle/gnupgkey.asc]
X-URL: [http://www.frontier.iarc.uaf.edu/~cswingle/]
X-Editor: VIM [http://www.vim.org]
X-message-flag: Consider Linux: fast, reliable, secure & free!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christopher Swingley <cswingle@iarc.uaf.edu> [2003-Apr-18 15:27 AKDT]:
> Inserting, mounting and then removing a USB mass storage device caused 
> the oops at the bottom of this message.  Afterwords USB mass storage 
> devices no longer worked.

I forgot to mention, I also umounted it (and waited for the little light 
to stop flashing) before pulling it out of the USB socket.

Chris
-- 
Christopher S. Swingley          email: cswingle@iarc.uaf.edu
IARC -- Frontier Program         Please use encryption.  GPG key at:
University of Alaska Fairbanks   www.frontier.iarc.uaf.edu/~cswingle/

