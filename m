Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275530AbRJAVLI>; Mon, 1 Oct 2001 17:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275539AbRJAVK5>; Mon, 1 Oct 2001 17:10:57 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:18340 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S275530AbRJAVKi>;
	Mon, 1 Oct 2001 17:10:38 -0400
Date: Mon, 01 Oct 2001 22:11:03 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Nick Craig-Wood <ncw@axis.demon.co.uk>, viro@math.psu.edu,
        Erik Andersen <andersen@codepoet.org>
Cc: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [CFT][PATCH] cleanup of partition code
Message-ID: <42604006.1001974263@[195.224.237.69]>
In-Reply-To: <200110010906.f9196NM32571@irishsea.craig-wood.com>
In-Reply-To: <200110010906.f9196NM32571@irishsea.craig-wood.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, 01 October, 2001 10:06 AM +0100 Nick Craig-Wood 
<ncw@axis.demon.co.uk> wrote:

> I don't think Acorn disks can have sectors
> bigger than 1k.

>From a very long time in the past when I used
to write interfaces to ARM stuff, I am /pretty/
sure I managed to get 4k sectors to work. As
this is about 10 years ago, and involved
some editing of some grungy BASIC HD format
program, I may be either wrong, or out of
date.

--
Alex Bligh
