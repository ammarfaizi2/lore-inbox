Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274684AbRJYOfs>; Thu, 25 Oct 2001 10:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274749AbRJYOfi>; Thu, 25 Oct 2001 10:35:38 -0400
Received: from theirongiant.weebeastie.net ([203.62.148.50]:14208 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S274684AbRJYOfW>; Thu, 25 Oct 2001 10:35:22 -0400
Date: Fri, 26 Oct 2001 00:35:15 +1000
From: CaT <cat@zip.com.au>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: Marton Kadar <marton.kadar@freemail.hu>, linux-kernel@vger.kernel.org
Subject: Re: concurrent VM subsystems
Message-ID: <20011026003515.A1341@zip.com.au>
In-Reply-To: <freemail.20010925100655.37794@fm3.freemail.hu> <Pine.LNX.4.33.0110251458020.6694-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110251458020.6694-100000@Expansa.sns.it>
User-Agent: Mutt/1.3.23i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 03:06:51PM +0200, Luigi Genoni wrote:
> I already exposed my opinion, and both Andrea and Rik know it very well.
> The VM for servers needs to be predictable, for desktops needs to be as
> fast as possible, also if it is a little less predictable and stable (who
> cares if you reboot you desktop once every two days?).

It doesn't matter if it's every 2 days or 2 years if it does it just
when you're doing something that must NOT be interrupted and you lose
a buttload of work. Stability is important in both a server AND desktop
environment.

-- 
CaT        "As you can expect it's really affecting my sex life. I can't help
           it. Each time my wife initiates sex, these ejaculating hippos keep
           floating through my mind."
                - Mohd. Binatang bin Goncang, Singapore Zoological Gardens
