Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbWB1VjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWB1VjW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 16:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWB1VjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 16:39:22 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:61645 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932502AbWB1VjV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 16:39:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e0rNv7IyMCanaCAMg4/bAYAEWZGbc7kWBwd2ik9UrpUDKsCOQe8SpdMTj4hayxKCaD0Jux+FUg66XggjiA3jMSZhjgX3iwz6ipggpva7g3hsZsuL89gfoxNZo07o1DjFjDEPhtDQCNvxqgxI+kWk/aGnDOv4h544PlMKCnfX8Bo=
Message-ID: <d120d5000602281339h777a9b73nb95bf6b6b5ee90c9@mail.gmail.com>
Date: Tue, 28 Feb 2006 16:39:18 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Matt Mackall" <mpm@selenic.com>, "Dave Jones" <davej@redhat.com>,
       "Adrian Bunk" <bunk@stusta.de>,
       "Dmitry Torokhov" <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
       "Zwane Mwaikambo" <zwane@commfireservices.com>,
       "Samuel Masham" <samuel.masham@gmail.com>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       cpufreq@lists.linux.org.uk, ak@suse.de
Subject: Re: Status of X86_P4_CLOCKMOD?
In-Reply-To: <20060228213428.GA31044@isilmar.linta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060222024438.GI20204@MAIL.13thfloor.at>
	 <200602212220.05642.dtor_core@ameritech.net>
	 <20060223195937.GA5087@stusta.de> <20060223204110.GE6213@redhat.com>
	 <20060228194628.GP4650@waste.org> <20060228200916.GA326@redhat.com>
	 <20060228204720.GD13116@waste.org>
	 <20060228205758.GA16268@isilmar.linta.de>
	 <20060228212632.GE13116@waste.org>
	 <20060228213428.GA31044@isilmar.linta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/06, Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> On Tue, Feb 28, 2006 at 03:26:32PM -0600, Matt Mackall wrote:
> > > So even if the battery lasts longer, you don't have anything of it, 'cause
> > > the CPU can even compute _less_ in this longer time-span. Remember that
> > > idling doesn't count...
> >
> > Which is different from other power-saving modes how? If it means I
> > can read my email longer on the plane, it's a power-saving mode.
>
> But you can't... [*]
...
> [*] unless the idling algorithm is broken and does not enter C2-type idle
> states.

Or box does not support anything but C1.

--
Dmitry
