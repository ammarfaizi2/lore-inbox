Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317550AbSFNCwW>; Thu, 13 Jun 2002 22:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317875AbSFNCwV>; Thu, 13 Jun 2002 22:52:21 -0400
Received: from host040.digeo.com ([12.110.81.40]:41600 "EHLO
	khem.blackfedora.com") by vger.kernel.org with ESMTP
	id <S317550AbSFNCwV>; Thu, 13 Jun 2002 22:52:21 -0400
To: <linux-kernel@vger.kernel.org>
Subject: SCSI host/channel/lun/part to /dev/sd* or maj/minor mapping
From: Mark Atwood <mra@pobox.com>
Date: 13 Jun 2002 19:52:17 -0700
In-Reply-To: <001e01c21349$f5f66060$f7f583d0@pcs686>
Message-ID: <m3660md126.fsf_-_@khem.blackfedora.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there a mapping between the Host,Channel,Id,Lun of a SCSI device as
reported in /proc/scsi/scsi, and the the /dev/sd* names and/or the
major/minor device numbers?

I've done some experamentation, and the more obvious ways of doing
the mapping dont seem to be 100%.

