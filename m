Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbVIEQTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbVIEQTI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVIEQTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:19:08 -0400
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:60274 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932314AbVIEQTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:19:06 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: GFS, what's remaining
Date: Mon, 5 Sep 2005 11:18:45 -0500
User-Agent: KMail/1.8.2
Cc: Daniel Phillips <phillips@istop.com>, Lars Marowsky-Bree <lmb@suse.de>,
       Andi Kleen <ak@suse.de>, linux clustering <linux-cluster@redhat.com>,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <20050905141432.GF5498@marowsky-bree.de> <200509051149.49929.phillips@istop.com>
In-Reply-To: <200509051149.49929.phillips@istop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509051118.45792.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 September 2005 10:49, Daniel Phillips wrote:
> On Monday 05 September 2005 10:14, Lars Marowsky-Bree wrote:
> > On 2005-09-03T01:57:31, Daniel Phillips <phillips@istop.com> wrote:
> > > The only current users of dlms are cluster filesystems.  There are zero
> > > users of the userspace dlm api.
> >
> > That is incorrect...
> 
> Application users Lars, sorry if I did not make that clear.  The issue is 
> whether we need to export an all-singing-all-dancing dlm api from kernel to 
> userspace today, or whether we can afford to take the necessary time to get 
> it right while application writers take their time to have a good think about 
> whether they even need it.
>

If Linux fully supported OpenVMS DLM semantics we could start thinking asbout
moving our application onto a Linux box because our alpha server is aging.

That's just my user application writer $0.02.

-- 
Dmitry
