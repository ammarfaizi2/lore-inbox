Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262659AbTCIXDN>; Sun, 9 Mar 2003 18:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbTCIXDM>; Sun, 9 Mar 2003 18:03:12 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:15842 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S262659AbTCIXDM>; Sun, 9 Mar 2003 18:03:12 -0500
Date: Sun, 9 Mar 2003 23:11:29 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: struct inode size reduction.
Message-ID: <20030310001129.GB13869@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
References: <20030309135402.GB32107@suse.de> <20030309224552.GA3047@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309224552.GA3047@werewolf.able.es>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 11:45:52PM +0100, J.A. Magallon wrote:

 > If you do not need gcc-2.95 support, you can use anonymous unions:
 > I have tested on gcc-3.0, 3.2.2, RH gcc-2.96-98, and 2.95.2. Only 2.95.2
 > fails.

What about the magick ancient version that sparc uses ?

		Dave

