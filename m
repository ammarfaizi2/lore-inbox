Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbTAKMI0>; Sat, 11 Jan 2003 07:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267197AbTAKMI0>; Sat, 11 Jan 2003 07:08:26 -0500
Received: from zamok.crans.org ([138.231.136.6]:1171 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S267196AbTAKMI0>;
	Sat, 11 Jan 2003 07:08:26 -0500
Date: Sat, 11 Jan 2003 13:17:12 +0100
To: Kees Bakker <kees.bakker@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.55 - loading bttv gives Unknown symbol videobuf_iolock
Message-ID: <20030111121712.GA7731@darwin.gaia.net>
References: <15903.18683.756507.997529@iris.hendrikweg.doorn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15903.18683.756507.997529@iris.hendrikweg.doorn>
User-Agent: Mutt/1.4i
X-Warning: Email may contain unsmilyfied humor and/or satire.
From: Vincent Hanquez <tab@tuxfamily.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 11:28:11PM +0100, Kees Bakker wrote:
> With 2.5.55 I get the following error in syslog when I load bttv:
> 
> bttv: Unknown symbol videobuf_iolock

same problem here.
compiling bttv in kernel (gruick) permit to watch TV on 2.5.55.

-- 
Tab
