Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263180AbTCXXUz>; Mon, 24 Mar 2003 18:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263206AbTCXXUz>; Mon, 24 Mar 2003 18:20:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14861 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263180AbTCXXUx>; Mon, 24 Mar 2003 18:20:53 -0500
Date: Mon, 24 Mar 2003 23:31:58 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_VT_CONSOLE in 2.5.6x ?
Message-ID: <20030324233158.E10370@flint.arm.linux.org.uk>
Mail-Followup-To: Louis Garcia <louisg00@bellsouth.net>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <1048546447.3058.3.camel@tiger> <33453.4.64.238.61.1048547120.squirrel@www.osdl.org> <1048548310.3388.7.camel@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1048548310.3388.7.camel@tiger>; from louisg00@bellsouth.net on Mon, Mar 24, 2003 at 06:25:10PM -0500
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 06:25:10PM -0500, Louis Garcia wrote:
> Well I can't find it there. I have a 2.5.65 tree and under character
> devices I have

you need:

CONFIG_INPUT=y

to allow the option you're looking for to show up.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

