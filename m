Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262987AbTCSM7F>; Wed, 19 Mar 2003 07:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262991AbTCSM7F>; Wed, 19 Mar 2003 07:59:05 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:59152 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262987AbTCSM7E>; Wed, 19 Mar 2003 07:59:04 -0500
Date: Wed, 19 Mar 2003 13:10:01 +0000
From: John Levon <levon@movementarian.org>
To: mikpe@csd.uu.se
Cc: Andrew Morton <akpm@digeo.com>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: apic-to-drivermodel conversion
Message-ID: <20030319131001.GC97434@compsoc.man.ac.uk>
References: <20030318202858.GA154@elf.ucw.cz> <20030318161852.41a703a4.akpm@digeo.com> <15992.18243.605716.244572@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15992.18243.605716.244572@gargle.gargle.HOWL>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18vdKU-0003JU-00*b8D760YRmOs*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 11:32:35AM +0100, mikpe@csd.uu.se wrote:

> Try this patch instead. This is my merge of my and Pavel's earlier
> patches, so it differs from Pavel's in some details.

Can you apply this one instead please Linus, it cleans up the horrible
set_nmi_pm_callback stuff I introduced in a much cleaner way ...

regards
john
