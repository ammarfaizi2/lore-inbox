Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbSJDHzc>; Fri, 4 Oct 2002 03:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261528AbSJDHzc>; Fri, 4 Oct 2002 03:55:32 -0400
Received: from gate.in-addr.de ([212.8.193.158]:61450 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S261517AbSJDHz3>;
	Fri, 4 Oct 2002 03:55:29 -0400
Date: Fri, 4 Oct 2002 10:00:51 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: RAID backup
Message-ID: <20021004080051.GB10028@marowsky-bree.de>
References: <3D9CA1C7.2000405@cfht.hawaii.edu> <CFEAJJEGMGECBCJFLGDBCENHCEAA.enorwood@effrem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CFEAJJEGMGECBCJFLGDBCENHCEAA.enorwood@effrem.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-03T16:59:57,
   Effrem Norwood <enorwood@effrem.com> said:

> With multiple inexpensive large disk arrays from companies like Network
> Appliance (NearStor) and Exstor (T-2120) organizations are asynchronously
> mirroring their data to geographically distant locations to prevent single
> points of failure with their arrays.

Let's just point out that Linux can do that too with drbd.

(I wonder if that will stay a separate module or whether it'll become a EVMS
plugin ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel
Research and Development, SuSE Linux AG
 
``Immortality is an adequate definition of high availability for me.''
	--- Gregory F. Pfister

