Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130150AbQLMP4V>; Wed, 13 Dec 2000 10:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130755AbQLMP4M>; Wed, 13 Dec 2000 10:56:12 -0500
Received: from fromage.dsndata.com ([198.183.6.16]:31752 "EHLO
	fromage.dsndata.com") by vger.kernel.org with ESMTP
	id <S130150AbQLMP4A>; Wed, 13 Dec 2000 10:56:00 -0500
Date: Wed, 13 Dec 2000 09:25:33 -0600
From: Jeff Epler <jepler@inetnebr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: strange directory problem
Message-ID: <20001213092531.A11604@inetnebr.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20001213141350.B8330@vega.digitel2002.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001213141350.B8330@vega.digitel2002.hu>; from lgb@vega.digitel2002.hu on Wed, Dec 13, 2000 at 02:13:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2000 at 02:13:51PM +0100, Gabor Lenart wrote:
> Hi,
> 
> lgb@vega:~$ uname -a
> Linux vega 2.2.18pre24 #1 Thu Dec 7 14:08:36 CET 2000 i686 unknown
> 
> I created a directory from shell (bash). The next ls didn't show it,
> I had to type ls second time too to get the changes. Is it a known bug?
> Is it fixed in 2.2.18final ?

NFS, or a local filesystem?

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
