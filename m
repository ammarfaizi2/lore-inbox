Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265560AbSJXRQI>; Thu, 24 Oct 2002 13:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265561AbSJXRQI>; Thu, 24 Oct 2002 13:16:08 -0400
Received: from almesberger.net ([63.105.73.239]:60166 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265560AbSJXRQH>; Thu, 24 Oct 2002 13:16:07 -0400
Date: Thu, 24 Oct 2002 14:22:00 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Vamsi Krishna S ." <vamsi@in.ibm.com>
Cc: Richard J Moore <richardj_moore@uk.ibm.com>,
       Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>
Subject: Re: 2.4 Ready list - Kernel Hooks
Message-ID: <20021024142200.L1421@almesberger.net>
References: <OF4A3346AB.B9CBFE3E-ON80256C5B.005B118D@portsmouth.uk.ibm.com> <20021023165009.I1421@almesberger.net> <20021024130835.A30737@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021024130835.A30737@in.ibm.com>; from vamsi@in.ibm.com on Thu, Oct 24, 2002 at 01:08:35PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vamsi Krishna S . wrote:
> So, hooks are designed, placed at well thought-out locations.
> Probes OTOH are mostly ad-hoc.

Yes, my point was that the same (general) mechanism should be
suitable for both types of use. However, ...

>> [kd]probes. I haven't looked at that part yet. Do you have the
>> infrastructure for this ?
>> 
> No, returning from caller will be much harder with [kd]probes.

... this seems to kill my grand unified hook/probe theory :-(

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
