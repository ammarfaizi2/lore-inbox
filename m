Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131980AbRC1QPc>; Wed, 28 Mar 2001 11:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131981AbRC1QPW>; Wed, 28 Mar 2001 11:15:22 -0500
Received: from mail1.upco.es ([130.206.70.227]:35906 "EHLO mail1.upco.es") by vger.kernel.org with ESMTP id <S131976AbRC1QPL>; Wed, 28 Mar 2001 11:15:11 -0500
Date: Wed, 28 Mar 2001 18:14:24 +0200
From: Romano Giannetti <romano@dea.icai.upco.es>
To: linux-kernel@vger.kernel.org
Subject: Re: Disturbing news..
Message-ID: <20010328181424.A15231@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>, linux-kernel@vger.kernel.org
References: <20010328163244.D11584@pern.dea.icai.upco.es> <Pine.GSO.4.21.0103280954140.26500-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0103280954140.26500-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Mar 28, 2001 at 09:57:47AM -0500
X-Edited-With-Muttmode: muttmail.sl - 2000-11-20 - RGtti 2001-01-29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2001 at 09:57:47AM -0500, Alexander Viro wrote:
> 
> On Wed, 28 Mar 2001, Romano Giannetti wrote:
> 
> > Now the binary can do much less harm than before, or am I missing something?
> > It have no access to real user data, but can use the system library and
> > services without changing anything in the system. 
> 
> You mean, like mailbombing the living hell out of somebody? Or playing
> interesting games with sending signals all over the place...

Yes, I was sure there were doors left, but --- it has no access to the
bookmark list of user, and can kill just user processes... that was what I
meant with "less harm" (never say never, I know...). 

           Romano 

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 411 132
