Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266488AbRGJO7O>; Tue, 10 Jul 2001 10:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266520AbRGJO6y>; Tue, 10 Jul 2001 10:58:54 -0400
Received: from weta.f00f.org ([203.167.249.89]:44162 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266488AbRGJO6n>;
	Tue, 10 Jul 2001 10:58:43 -0400
Date: Wed, 11 Jul 2001 02:58:37 +1200
From: Chris Wedgwood <cw@f00f.org>
To: "Butter, Frank" <Frank.Butter@otto.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: IPC kernel-params
Message-ID: <20010711025837.C32067@weta.f00f.org>
In-Reply-To: <4B6025B1ABF9D211B5860008C75D57CC0271BC60@NTOVMAIL04>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B6025B1ABF9D211B5860008C75D57CC0271BC60@NTOVMAIL04>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 04:16:03PM +0200, Butter, Frank wrote:

    could anybody please could give me a hint on how to adjust the
    IPC-parameters like MSGMNB etc. in the 2.4.x-kernels?

have you tried

        echo <n> > /proc/sys/kernel/msgmnb

sort of thing?



  --cw
