Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTJASZI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 14:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbTJASZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 14:25:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23209 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262714AbTJASYm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 14:24:42 -0400
Date: Wed, 1 Oct 2003 19:24:40 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Makan Pourzandi <Makan.Pourzandi@ericsson.ca>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Axelle Apvrille <Axelle.Apvrille@ericsson.ca>,
       Vincent Roy <vincent.roy@ericsson.ca>,
       David Gordon <davidgordonca@yahoo.ca>, socrate@infoiasi.ro
Subject: Re: [ANNOUNCE] DigSig 0.2: kernel module for digital signature verification for binaries
Message-ID: <20031001182440.GV7665@parcelfarce.linux.theplanet.co.uk>
References: <3F733FD3.60502@ericsson.ca> <20031001102631.GC398@elf.ucw.cz> <3F7AD795.1040001@ericsson.ca> <20031001141718.GT7665@parcelfarce.linux.theplanet.co.uk> <3F7B1987.3050104@ericsson.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F7B1987.3050104@ericsson.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 02:14:31PM -0400, Makan Pourzandi wrote:
> Hi Viro,
> 
> Obviously, I failed to show that the main functionality of digsig is to 
> avoid the execution of __normal__ rootkits, Trojan horses and other 
> malicious binaries on your system. 

<shrug> so in a month rootkits get updated and we are back to square 1,
with additional mess from patch...
