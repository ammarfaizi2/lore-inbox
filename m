Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266864AbRH0Tgr>; Mon, 27 Aug 2001 15:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266263AbRH0Tgh>; Mon, 27 Aug 2001 15:36:37 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:2449 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S267043AbRH0TgX>;
	Mon, 27 Aug 2001 15:36:23 -0400
Date: Mon, 27 Aug 2001 20:36:37 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <516781015.998944596@[169.254.198.40]>
In-Reply-To: <20010827155621Z16272-32385+261@humbolt.nl.linux.org>
In-Reply-To: <20010827155621Z16272-32385+261@humbolt.nl.linux.org>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Monday, 27 August, 2001 6:02 PM +0200 Daniel Phillips 
<phillips@bonn-fries.net> wrote:

> On the other hand, we
> will penalize faster streams that way

Penalizing faster streams for the same number
of pages is probably a good thing
as they cost less time to replace.

--
Alex Bligh
