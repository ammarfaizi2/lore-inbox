Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280430AbRKEJpZ>; Mon, 5 Nov 2001 04:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280431AbRKEJpP>; Mon, 5 Nov 2001 04:45:15 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:38565 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S280430AbRKEJpJ>;
	Mon, 5 Nov 2001 04:45:09 -0500
Date: Mon, 05 Nov 2001 09:45:05 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Mike Fedyk <mfedyk@matchmail.com>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [Ext2-devel] disk throughput
Message-ID: <672366870.1004953505@[195.224.237.69]>
In-Reply-To: <200111050554.fA55swt273156@saturn.cs.uml.edu>
In-Reply-To: <200111050554.fA55swt273156@saturn.cs.uml.edu>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, 05 November, 2001 12:54 AM -0500 "Albert D. Cahalan" 
<acahalan@cs.uml.edu> wrote:

> By putting directories far apart, you leave room for regular
> files (added at some future time) to be packed close together.

Mmmm... but if you read ahead your directories (see lkml passim)
I'd be prepared to be the gain here is either minimized, or
negative.

--
Alex Bligh
