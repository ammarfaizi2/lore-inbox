Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263185AbTCSV2j>; Wed, 19 Mar 2003 16:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263183AbTCSV2j>; Wed, 19 Mar 2003 16:28:39 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:39942 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S263185AbTCSV2U>;
	Wed, 19 Mar 2003 16:28:20 -0500
Date: Wed, 19 Mar 2003 22:39:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: mirrors <mirrors@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Deprecating .gz format on kernel.org
Message-ID: <20030319213917.GB1030@mars.ravnborg.org>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	mirrors <mirrors@kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3E78D0DE.307@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E78D0DE.307@zytor.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 12:19:42PM -0800, H. Peter Anvin wrote:
> Hello everyone,
> 
> At some point it probably would make sense to start deprecating .gz
> format files from kernel.org.

It is a convinient feature that I can download the kernel now and then
when at work (no linux) - and it makes it a bit simpler to use
an archiver that has native support for the format used.
Winzip, being the only allowed archiver at work, does not
have native bz2 support.

I have a .bz2 commandline version on the windoze machine so I will cope,
but mainly to let you know that deprecating .gz you will make it
difficult for a minority to read the kernel src.

	Sam
