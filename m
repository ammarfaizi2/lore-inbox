Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290771AbSBLGJi>; Tue, 12 Feb 2002 01:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290789AbSBLGJ2>; Tue, 12 Feb 2002 01:09:28 -0500
Received: from leapster.zoic.org ([203.30.75.10]:45832 "HELO
	leapster.dwerryhouse.com.au") by vger.kernel.org with SMTP
	id <S290771AbSBLGJJ>; Tue, 12 Feb 2002 01:09:09 -0500
Date: Tue, 12 Feb 2002 17:09:06 +1100
From: "Nick 'Sharkey' Moore" <sharkey@zoic.org>
To: linux-kernel@vger.kernel.org
Subject: Re: faking time
Message-ID: <20020212170906.K26856@dwerryhouse.com.au>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3C67AFD3.722C5471@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C67AFD3.722C5471@ntlworld.com>; from super.aorta@ntlworld.com on Mon, Feb 11, 2002 at 11:49:39AM +0000
X-URL: http://zoic.org/sharkey/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 11:49:39AM +0000, SA products wrote:
> 
> I want to fake the time returned by the time() system call so that for a
> limited number of user space programs [...]

Hi. I'm experimenting with a patch to User Mode Linux which enables 
it to do this sort of thing.

Other responses (eg, LD_PRELOAD) here are probably more directly useful
to you, but I thought User Mode Linux bore mentioning anyway, depending
on what you're trying to achieve[1].

	<URL:http://user-mode-linux.sourceforge.net/>

-----sharks
[1] Just out of interest, what _are_ you trying to achieve?
