Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTFOLsg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 07:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbTFOLsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 07:48:36 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:7184 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262164AbTFOLsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 07:48:35 -0400
Date: Sun, 15 Jun 2003 14:02:24 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.21 released
Message-ID: <20030615120224.GA31285@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200306131453.h5DErX47015940@hera.kernel.org> <20030613165628.GE28609@in-ws-001.cid-net.de> <20030613172226.GB9339@merlin.emma.line.org> <20030613182924.A32241@infradead.org> <20030614233527.08831e2a.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030614233527.08831e2a.diegocg@teleline.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jun 2003, Diego Calleja García wrote:

> Just a small suggestion: Why not ALSA?
> I mean, 2.5 is there for new things, indeed. But alsa are drivers (ie: it
> shouldnt affect core code and you haven't to use them if you don't want) ,
> and after all it's one of those things that lots of people have to add (a
> lot of times manually and lots of people doesn't want to know how to patch
> a kernel; although all distros ship it).

Well, I can always compile ALSA externally. I haven't succeeded in
compiling XFS externally with recent 2.4.21-rc (except -ac ;-)

> In some cases, alsa gives you decent sound (in the case of my sound card,
> which is both supported by oss and alsa). Other times, you've not a choice.

And with some chips (CMI8330), Alsa doesn't work for me (haven't checked
recent versions though).

-- 
Matthias Andree
