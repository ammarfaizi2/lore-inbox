Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbWAXDtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWAXDtO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 22:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWAXDtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 22:49:14 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:42983 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030287AbWAXDtO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 22:49:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=McrceeV8q+DjlI01QQV9hG6m7Yy1vo/nUDzW0R2PpFrCXpwhHyXkx7kh9GcN5bRacqrLFh4wJOEFxCxblQeRYqX45WFvMzWsonMWyQ2gfo3Gz9ErQCGNBNth1X73wf0yGC6jSMtC0FN9AY/6CZ70otdhF80EIxZiwpO560QWn8Q=
Date: Tue, 24 Jan 2006 04:48:46 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Diego Calleja <diegocg@gmail.com>
Cc: paulkf@microgate.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: pppd oopses current linu's git tree on disconnect
Message-Id: <20060124044846.de6508eb.diegocg@gmail.com>
In-Reply-To: <20060123034243.22ba0a8f.diegocg@gmail.com>
References: <20060119010601.f259bb32.diegocg@gmail.com>
	<1137692039.3279.1.camel@amdx2.microgate.com>
	<20060119230746.ea78fcf4.diegocg@gmail.com>
	<43D01537.40705@microgate.com>
	<20060123034243.22ba0a8f.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 23 Jan 2006 03:42:43 +0100,
Diego Calleja <diegocg@gmail.com> escribió:

> Ok - I seem to be able to reproduce it in a unpatched kernel using
> a lengthy session. I will try your patch and report back.

It doesn't seems to happen today at least, after a lentghty session
similar to the one which triggered the bug.
