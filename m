Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319531AbSIGWTT>; Sat, 7 Sep 2002 18:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319534AbSIGWTT>; Sat, 7 Sep 2002 18:19:19 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:55559 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S319531AbSIGWTT>; Sat, 7 Sep 2002 18:19:19 -0400
Date: Sat, 7 Sep 2002 15:23:51 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: file locking looks strange
Message-ID: <20020907222350.GA24809@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <44499.213.68.24.98.1031409116.rocnet@deathstar.of.rocnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44499.213.68.24.98.1031409116.rocnet@deathstar.of.rocnet.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2002 at 04:31:56PM +0200, Claus Rosenberger wrote:
> How i can informations about file locking for applications.
> 
> if i open a document with one application on the terminalserver and try to
> open the same document  in another session i can write on the second
> session. this happens for example with openoffice. how i can really lock
> the file if one application open this doc for reading and writing ?

start with 'man -k lock|grep file'  That will give you some
starting points.  If you need more any book on UNIX or Linux
programming that doesn't list both methods isn't worth buying.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
