Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132223AbRAHWHW>; Mon, 8 Jan 2001 17:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135752AbRAHWHM>; Mon, 8 Jan 2001 17:07:12 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:56281 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S132223AbRAHWHA>; Mon, 8 Jan 2001 17:07:00 -0500
Date: Mon, 8 Jan 2001 17:06:17 -0500
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: DRI doesn't work on 2.4.0 but does on prerelease-ac5
Message-ID: <20010108170617.A16354@nostromo.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A5A087F.F1C45380@goingware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5A087F.F1C45380@goingware.com>; from crawford@goingware.com on Mon, Jan 08, 2001 at 06:35:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael D. Crawford (crawford@goingware.com) said: 
> This makes me suspect it's not really working, or else my build of the Mesa-3.4
> library wasn't configured right - but note that if I disable DRI, one of the
> Mesa demos will comment that it's not available.

It sounds as if you're using a Mesa lib that doesn't support the
X DRI stuff, just the software renderer.

Bill
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
