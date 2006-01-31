Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWAaMY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWAaMY7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 07:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWAaMY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 07:24:59 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:7616 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750782AbWAaMY6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 07:24:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CXUaTKvK69xkh0565tzSDunAyPOoX6zTxWKikwS+SmPslAMxg44b52wN5gdmX5RCjKGDMj/b7FSxd8BvuPDkkFFir+F5sSY45zyE6OCKzvg4qpgbziqYJEc5G8IZLnwO3mi7Kz8xQTF4l+qzwYc2sztcrvIBsqRLOJDYg0+b25o=
Message-ID: <5a2cf1f60601310424w6a64c865u590652fbda581b06@mail.gmail.com>
Date: Tue, 31 Jan 2006 13:24:58 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: j@bitron.ch, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       James@superbug.co.uk, acahalan@gmail.com
In-Reply-To: <43DF3C3A.nail2RF112LAB@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	 <43D7A7F4.nailDE92K7TJI@burner>
	 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
	 <43D7B1E7.nailDFJ9MUZ5G@burner>
	 <20060125230850.GA2137@merlin.emma.line.org>
	 <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner>
	 <1138642683.7404.31.camel@juerg-pd.bitron.ch>
	 <43DF3C3A.nail2RF112LAB@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> Jürg Billeter <j@bitron.ch> wrote:
[...]
> Users like to be able to get a list of posible targets for a single protocol.

The Linux users (I know of) like to be able to reference their drives
the way their Operating System names them.

If it's /dev/cdrw, then it's /dev/cdrw, not '1,0,0'.

Should we make a poll ?

Jerome
