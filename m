Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVBVASz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVBVASz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 19:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVBVASz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 19:18:55 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:58519 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262157AbVBVASy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 19:18:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=jUonlJWtGl2Uj2t/3h5XHSHZaOA8qMw4LTy+y2eBCh0DGR52FkPJv+xrcViqIMwrtliz1vKF8RIfiNpaf6MQNoQ8CryFnLGov7ANksUS2yT9oBTRWMG10HC0kITcZ4G3/N1wpCOfROmqnumIIoKeVq9KY/T3d//0VoRCKvDZej8=
Message-ID: <772d45630502211618565ee170@mail.gmail.com>
Date: Mon, 21 Feb 2005 19:18:52 -0500
From: Bryan Veal <bryan.veal@gmail.com>
Reply-To: Bryan Veal <bryan.veal@gmail.com>
To: Brandy Chin <brandy.chin@gmail.com>
Subject: Re: Disks Activity Stats
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bbef41570502211601f5a47be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <bbef41570502211601f5a47be@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2005 19:01:54 -0500, Brandy Chin <brandy.chin@gmail.com> wrote:
> Hello All,
> 
> I'm having some trouble in getting the number of disk blocks
> read/written per second.  I found the link on /proc/diskstats but I
> don't see that parameter somewhere.  If there's a way to get the
> number, it'd be great.  Otherwise some cursory advice, pointer to more
> links would be fine.

Try the iostat tool in the sysstat utilities:

http://perso.wanadoo.fr/sebastien.godard/
