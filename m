Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbTAVOJq>; Wed, 22 Jan 2003 09:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261205AbTAVOJq>; Wed, 22 Jan 2003 09:09:46 -0500
Received: from noc7.BelWue.DE ([129.143.2.15]:44956 "EHLO smtp2.BelWue.DE")
	by vger.kernel.org with ESMTP id <S261173AbTAVOJp>;
	Wed, 22 Jan 2003 09:09:45 -0500
Date: Wed, 22 Jan 2003 15:18:51 +0100 (MET)
From: Oliver Tennert <tennert@science-computing.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client problem and IO blocksize
In-Reply-To: <15918.40855.583602.576856@charged.uio.no>
Message-ID: <Pine.GHP.4.02.10301221459090.7581-100000@alderaan.science-computing.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK thanks. But I am sorry to push you once more, Trond: can you now give
me just a brief explanation of difference between the "wsize" option and
the "wtmult" attribute? Is it better now to disable O_DIRECT and use a
larger wsize/rsize, or to enable it and be content with the parameters it
uses?

(Sorry, I have got myself only a vague idea of the answer, but I am not so
expert in all this I/O stuff and its different layers.)

Many thanks and best regards.

Oliver


		   Dr. Oliver Tennert
                    
  		   +49 -7071 -9457-598
                          
 		   e-mail: O.Tennert@science-computing.de
  		   science + computing AG
  		   Hagellocher Weg 71                  
   		   D-72070 Tuebingen                  
                                     



