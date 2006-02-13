Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWBMQ3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWBMQ3n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWBMQ3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:29:43 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:22230 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932107AbWBMQ3m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:29:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=mHPcmo1bkHvspJXNej5Zujpe4cXqgJrKnSUMZUt7xt/LnzmC4Rl5RMg+9xEx/1t47NcOIzIHL8/ESpdB25K+ejV9NtXTVcERHl58v8cqg1AEBO+iQF50uk6xl38IU5uKSVrNDn0wBGi83IU9BMJqA82F1fxMBzgWX30nPkvzSOs=
Date: Mon, 13 Feb 2006 17:28:32 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: schilling@fokus.fraunhofer.de, fmalita@gmail.com, tytso@mit.edu,
       peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-Id: <20060213172832.c88b4846.diegocg@gmail.com>
In-Reply-To: <43F0AC22.nailKUS1AW83M9@burner>
References: <mj+md-20060209.173519.1949.atrey@ucw.cz>
	<43EC71FB.nailISD31LRCB@burner>
	<20060210114721.GB20093@merlin.emma.line.org>
	<43EC887B.nailISDGC9CP5@burner>
	<mj+md-20060210.123726.23341.atrey@ucw.cz>
	<43EC8E18.nailISDJTQDBG@burner>
	<Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr>
	<43EC93A2.nailJEB1AMIE6@burner>
	<20060210141651.GB18707@thunk.org>
	<43ECA3FC.nailJGC110XNX@burner>
	<20060210145238.GC18707@thunk.org>
	<43ECA934.nailJHD2NPUCH@burner>
	<20060210172428.6c857254.diegocg@gmail.com>
	<43F063A8.nailKUS7174MV@burner>
	<43F0A760.90405@gmail.com>
	<43F0AC22.nailKUS1AW83M9@burner>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 13 Feb 2006 16:56:18 +0100,
Joerg Schilling <schilling@fokus.fraunhofer.de> escribió:

> I did not write st_rdev and from my previous mail it was obvioys that 
> I was referring to st_dev.


Well, and everbody else was referring to st_rdev, including the email
you answered....
