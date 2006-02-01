Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422961AbWBAVuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422961AbWBAVuA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 16:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422962AbWBAVuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 16:50:00 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:39885 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422961AbWBAVuA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 16:50:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G5oUVpX019dsd3L4k6pf/2UgCXCoCaSz+r5EORUK6O9rs6snvDUKmnPtIr7oATxbbiHZQaauCSqdaunJgjq98/VjSVwCreccuKJek/WCm6wL4Il7ga8XnGLaiBJV1oYS55OI6Wy70l3Cw4Pp19RKIXYhVg8n7jCCh75VS3uODWE=
Message-ID: <441e43c90602011349ta6ad10axa3fdd93c62c71d36@mail.gmail.com>
Date: Wed, 1 Feb 2006 15:49:59 -0600
From: Ian Kester-Haney <ikesterhaney@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <Pine.LNX.4.61.0602011612520.22529@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	 <43D7B1E7.nailDFJ9MUZ5G@burner>
	 <20060125230850.GA2137@merlin.emma.line.org>
	 <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner>
	 <1138642683.7404.31.camel@juerg-pd.bitron.ch>
	 <43DF3C3A.nail2RF112LAB@burner>
	 <mj+md-20060131.104748.24740.atrey@ucw.cz>
	 <43DF65C8.nail3B41650J9@burner>
	 <Pine.LNX.4.61.0602011612520.22529@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't actively developed applications use the current methods for
accessing ddevices on target operating systems.  It seems to me that
linux/gnu users are moving away from cdrecord and it ilk because of
the artificial limitations imposed by its libscg counterpart. 
Backward compatibility is being phased out in the linux kernel to
allow for better ways to access and use devices in the system.  While
the technical nature of transport specifications might be tracked down
to an underlying SCSI mechanism, it is by no means an exclusive deal. 
Perhaps linux doesn't need cdrecord and this whole mess will go away.
Real users don't care as long as it works, even the old kernel used
/dev/* names.
Give it up.

---------------------------------------------
Only morons respond to flames
guilty as charged
----------------------------------------------
