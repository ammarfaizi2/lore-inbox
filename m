Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274276AbRIYATX>; Mon, 24 Sep 2001 20:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274277AbRIYATN>; Mon, 24 Sep 2001 20:19:13 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:5139 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S274276AbRIYATD> convert rfc822-to-8bit; Mon, 24 Sep 2001 20:19:03 -0400
Date: Tue, 25 Sep 2001 02:19:28 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Message-ID: <20010925021928.C22073@emma1.emma.line.org>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20010924215825Z274182-761+12384@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20010924215825Z274182-761+12384@vger.kernel.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001, Dieter Nützel wrote:

[fast write cache]
> Do you know of a Linux SCSI tool to enable it for testing purposes?

scsiinfo and scsi-config should do. They shipped with my SuSE Linux 7.0
and have been available on SuSE systems for ages.
