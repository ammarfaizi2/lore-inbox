Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbTL1K6i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 05:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbTL1K6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 05:58:38 -0500
Received: from cc15467-a.groni1.gr.home.nl ([217.120.147.78]:33601 "HELO
	boetes.org") by vger.kernel.org with SMTP id S265062AbTL1K6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 05:58:36 -0500
Date: Sun, 28 Dec 2003 11:58:36 +0100
From: Han Boetes <han@mijncomputer.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 kernel panic
Message-ID: <20031228105858.GA16148@boetes.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031228020759.GA2158@Master.Wizards>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031228020759.GA2158@Master.Wizards>
X-GPG-Key: http://www.xs4all.nl/~hanb/keys/Han_pubkey.gpg
X-GPG-Fingerprint: EB66 D194 AB3F 4C57 49EF 6795 44AE E0D8 3F38 7301
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Murray J. Root wrote:
> P4 2GHz
> ASUS P4S533 mainboard
> 1G PC2700 RAM
> GF2 GTS video using nv driver
> 2.6.0 compiled with gcc 3.3.2
> 
> At boot kernel gets:
>    INIT: cannot execute "/etc/rc.d/rc.sysinit"
> then panic.
> 
> Same configuration for 2.6.0-test11 and earlier works fine.

Update your gcc-rpm and recompile



# Han
