Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276569AbRJCRDQ>; Wed, 3 Oct 2001 13:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276552AbRJCRDJ>; Wed, 3 Oct 2001 13:03:09 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:53001 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S276550AbRJCRCu>; Wed, 3 Oct 2001 13:02:50 -0400
Date: Wed, 3 Oct 2001 19:03:15 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?
Message-ID: <20011003190315.G21866@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0110030938130.4835-100000@imladris.rielhome.conectiva> <Pine.LNX.4.30.0110031448460.16788-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0110031448460.16788-100000@Appserv.suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Oct 2001, Dave Jones wrote:

> Alan mentioned this was something to do with the IBM hard disk
> having strange write-cache properties that confuse ext3.

hdparm -W0 /dev/hda is your friend.
