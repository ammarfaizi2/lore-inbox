Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262283AbSJOCsc>; Mon, 14 Oct 2002 22:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262290AbSJOCsc>; Mon, 14 Oct 2002 22:48:32 -0400
Received: from [12.36.124.2] ([12.36.124.2]:56237 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S262283AbSJOCsb>; Mon, 14 Oct 2002 22:48:31 -0400
Mime-Version: 1.0
Message-Id: <p05200b57b9d133abc6d6@[207.213.214.37]>
In-Reply-To: <20021015043722.A9562@wotan.suse.de>
References: <288F9BF66CD9D5118DF400508B68C44604758B78@orsmsx113.jf.intel.com>
 <20021015043722.A9562@wotan.suse.de>
Date: Mon, 14 Oct 2002 19:54:15 -0700
To: Andi Kleen <ak@suse.de>, "Feldman, Scott" <scott.feldman@intel.com>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: Update on e1000 troubles (over-heating!)
Cc: "'Ben Greear'" <greearb@candelatech.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 4:37am +0200 10/15/02, Andi Kleen wrote:
>  > Ben, I checked the datasheet for the part shown in the lspci dump, and it
>>  shows an operating temperature of 0-55 degrees C.  You said you measured 50
>>  degrees C, so you're within the safe range.  Did the fans help?
>
>The thermometer he used likely showed a much lower temperature than what was
>actually on the die. 5-10 C more are not unlikely. It's hard to measure chip
>temperatures accurately without an on die thermal diode or special kit.
>So I would expect that when an external normal thermometer showed 50C
>it was already operating out of spec.

The datasheet's for the card, so the operating temperature is surely 
ambient, not die temperature. "Ambient measured how?" would be a 
reasonable question, though.
-- 
/Jonathan Lundell.
