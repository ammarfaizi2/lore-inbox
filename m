Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313510AbSDHInQ>; Mon, 8 Apr 2002 04:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313529AbSDHInP>; Mon, 8 Apr 2002 04:43:15 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:58356
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313510AbSDHInO>; Mon, 8 Apr 2002 04:43:14 -0400
Date: Mon, 8 Apr 2002 01:45:15 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Stevie O <stevie@qrpff.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Renaming internal names of network interfaces
Message-ID: <20020408084515.GQ961@matchmail.com>
Mail-Followup-To: Stevie O <stevie@qrpff.net>, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020407013139.00acf4d0@whisper.qrpff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 01:42:08AM -0500, Stevie O wrote:
> I recall some discussions of MAC address changing, etc., and some of the
messages referred to a way of changing the name Linux (and thus anything
using SIOGETIF or whatever) uses to refer to an interface. I can't remember
any specifics, so I can't find anything in archives :( Could someone please
point me in the right direction?     
> 

Check out bin/ip from the iproute package (in debian at least) specifically
"ip link name" "ip link help" should help.

Mike
