Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131636AbRCODFU>; Wed, 14 Mar 2001 22:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131637AbRCODFL>; Wed, 14 Mar 2001 22:05:11 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:50624 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131635AbRCODFG>; Wed, 14 Mar 2001 22:05:06 -0500
Message-ID: <3AB0327B.645C7B5@redhat.com>
Date: Wed, 14 Mar 2001 22:09:47 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: scsi_scan problem.
In-Reply-To: <3AB028BE.E8940EE6@redhat.com> <20010314213543.A30816@devserv.devel.redhat.com> <3AB030F6.246C6F23@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

> Patches welcomed.  The one I sent already works on a fiber channel setup (the
> qla2x00 in question is fc and so is the Clariion array it's connected to, no
> detrimental side effects from scanning the box) and so I'm not inclined to add
> a REPORT LUNs section to the code unless absolutely necessary.

Clarification, I think REPORT LUNS support is a 2.5 thing, not a stick it in
now thing.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
