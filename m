Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276600AbRJCRhN>; Wed, 3 Oct 2001 13:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276601AbRJCRhD>; Wed, 3 Oct 2001 13:37:03 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:55802 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S276600AbRJCRg5>; Wed, 3 Oct 2001 13:36:57 -0400
Date: Wed, 3 Oct 2001 18:36:51 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Dave Jones <davej@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
        "sebastien.cabaniols" <sebastien.cabaniols@laposte.net>,
        linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: [POT] Which journalised filesystem ?
Message-ID: <20011003183651.D5209@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0110030938130.4835-100000@imladris.rielhome.conectiva> <Pine.LNX.4.30.0110031448460.16788-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0110031448460.16788-100000@Appserv.suse.de>; from davej@suse.de on Wed, Oct 03, 2001 at 02:54:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 03, 2001 at 02:54:17PM +0200, Dave Jones wrote:

> > Personally I like ext3 a lot.  I've been using it for almost a
> > year now and it has never given me trouble.
> 
> I've similar experiences with ext3, except for one bad instance
> recently when I put it on my laptop. Lots of asserts were triggered,
> and on reboot it couldn't find the journal, the superblock,
> or the backup superblocks. I spent a few hours trying to get data
> back, and eventually gave up and reformatted as ext2.

Which laptop?  I've seen several reports of disk corruption with
recent kernels on certain laptops.

Cheers,
 Stephen
