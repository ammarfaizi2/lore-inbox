Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131986AbRDSSKU>; Thu, 19 Apr 2001 14:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbRDSSKL>; Thu, 19 Apr 2001 14:10:11 -0400
Received: from line113.comsat.net.ar ([200.47.131.113]:10512 "HELO
	mail.xaire.com") by vger.kernel.org with SMTP id <S131886AbRDSSJy>;
	Thu, 19 Apr 2001 14:09:54 -0400
Date: Thu, 19 Apr 2001 15:01:42 -0300
From: John Lenton <john@grulic.org.ar>
To: Helge Hafting <helgehaf@idb.hist.no>
Cc: Jeremy Jackson <jerj@coplanar.net>, linux-kernel@vger.kernel.org
Subject: Re: Is there a way to turn file caching off ?
Message-ID: <20010419150142.A1817@grulic.org.ar>
In-Reply-To: <Pine.LNX.3.96.1010418134153.20558A-100000@medusa.sparta.lu.se> <3ADD99E8.FB7F8542@coplanar.net> <3ADE9FFA.3E8476C2@idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3ADE9FFA.3E8476C2@idb.hist.no>; from helgehaf@idb.hist.no on Thu, Apr 19, 2001 at 10:21:14AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 10:21:14AM +0200, Helge Hafting wrote:
> A program may know its own access pattern, but it don't usually know
> future access patterns.  Well, backing up the entire fs could benefit
> from a something like this, you probably won't need the backup again
> soon.  But this is hard to know in many other cases.

tar --please-leave-this-in-cache-pretty-please ?

-- 
John Lenton (john@grulic.org.ar) -- Random fortune:
Si los bugs te abruman, cierra tu Windows.
