Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292399AbSB0QLk>; Wed, 27 Feb 2002 11:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292514AbSB0QLR>; Wed, 27 Feb 2002 11:11:17 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:38647 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S292116AbSB0QK5>; Wed, 27 Feb 2002 11:10:57 -0500
Message-ID: <3C7D0510.2C300D12@redhat.com>
Date: Wed, 27 Feb 2002 16:10:56 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-26beta.16smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
In-Reply-To: <20020227125611.A20415@stud.ntnu.no> <20020227.040653.58455636.davem@redhat.com> <20020227132454.B24996@stud.ntnu.no> <20020227.042845.54186884.davem@redhat.com> <20020227.042845.54186884.davem@redhat.com>; from davem@redhat.com on Wed Feb 27 2002 at 04:28:45AM -0800 <20020227170321.B22422@stud.ntnu.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Langås wrote:
> 
> David S. Miller:
> > At this point I'm mostly interested in if it works at all :-)
> > If the answer is yes, tell me that and then you can feel
> > free to experiment with jumbo frames et al. to discover
> > other bugs in the driver :-)
> 
> Just tested with MTU set at 1500 for now, but it seems to work fine, did a
> netcat between two boxes on the same switch and got around 80MB/sec.
> 
> Any programs or anything that could do a serious stresstest?  (Both hosts
> are Dell PowerEdge 2550, RedHat Linux 7.2).

google for nttcp
runs a nice tcp performance test...
