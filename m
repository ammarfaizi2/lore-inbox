Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSEUD6Q>; Mon, 20 May 2002 23:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316502AbSEUD6P>; Mon, 20 May 2002 23:58:15 -0400
Received: from w007.z208177141.sjc-ca.dsl.cnc.net ([208.177.141.7]:51629 "HELO
	mail.gurulabs.com") by vger.kernel.org with SMTP id <S316500AbSEUD6O>;
	Mon, 20 May 2002 23:58:14 -0400
Date: Mon, 20 May 2002 21:58:14 -0600 (MDT)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@localhost.localdomain
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael@hostsharing.net" <michael@hostsharing.net>
Subject: Re: suid bit on directories
In-Reply-To: <Pine.LNX.4.44.0205202122260.24416-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0205202157150.24416-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2002, Dax Kelson wrote:

> Example 1:
> 
> /home/bob/public_html
> 
> public_html  is user/group  bob/httpd
> 
> the perms are 2770

I meant 4770 since we are discussing a hypothetical SUID directory.

