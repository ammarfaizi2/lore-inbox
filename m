Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281455AbRKFEaQ>; Mon, 5 Nov 2001 23:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281453AbRKFEaH>; Mon, 5 Nov 2001 23:30:07 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:5879
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281450AbRKFE3z>; Mon, 5 Nov 2001 23:29:55 -0500
Date: Mon, 5 Nov 2001 20:29:48 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Robert Love <rml@tech9.net>
Cc: "Mohammad A. Haque" <mhaque@haque.net>, Terminator <jimmy@mtc.dhs.org>,
        linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.14 compiling fail for loop device
Message-ID: <20011105202948.C665@mikef-linux.matchmail.com>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	"Mohammad A. Haque" <mhaque@haque.net>,
	Terminator <jimmy@mtc.dhs.org>, linux-kernel@vger.kernel.org
In-Reply-To: <E290D3DA-D26B-11D5-A0A2-00306569F1C6@haque.net> <1005020081.897.4.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1005020081.897.4.camel@phantasy>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 11:14:40PM -0500, Robert Love wrote:
> On Mon, 2001-11-05 at 23:08, Mohammad A. Haque wrote:
> > Safe to remove those two lines from loop.c? Other calls of deactive_page 
> > were just removed it seemed.
> 
> Yes, it is.  I am sure that will be exactly what 2.4.15-pre1 does.
> 

This is why 2.4.14 should've been 2.4.14pre9!  

I thought Linus was going to keep the changes from pre to final to a
minimum.  Actually, I don't think there should be *any* difference between
the last pre and the released kernel...

Mike
