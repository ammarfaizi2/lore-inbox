Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290860AbSBFWvN>; Wed, 6 Feb 2002 17:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290853AbSBFWu1>; Wed, 6 Feb 2002 17:50:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36109 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290874AbSBFWsl>; Wed, 6 Feb 2002 17:48:41 -0500
Message-ID: <3C61B2C3.1000005@zytor.com>
Date: Wed, 06 Feb 2002 14:48:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Asynchronous CDROM Events in Userland
In-Reply-To: <Pine.LNX.4.30.0202032333200.1158-100000@rtlab.med.cornell.edu> <a3l4uc@cesium.transmeta.com> <20020206142259.A37@toy.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> 
> It may not eat CPU but it will definitely eat memory... Because polling
> means deamon that normally could be swapped out needs to stay in memory.
>


At least a small part of it, yes.

	-hpa



