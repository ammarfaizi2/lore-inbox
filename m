Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317602AbSHUA3v>; Tue, 20 Aug 2002 20:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317606AbSHUA3v>; Tue, 20 Aug 2002 20:29:51 -0400
Received: from hoemail2.lucent.com ([192.11.226.163]:51416 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S317602AbSHUA3u>; Tue, 20 Aug 2002 20:29:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15714.57320.918331.932316@gargle.gargle.HOWL>
Date: Tue, 20 Aug 2002 20:33:44 -0400
From: stoffel@lucent.com
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: automount doesn't "follow" bind mounts
In-Reply-To: <20020820180956.L21269@redhat.com>
References: <Pine.LNX.4.44.0208201752430.23681-100000@r2-pc.dcs.qmul.ac.uk>
	<ajuahu$hf$1@cesium.transmeta.com>
	<ajucmu$1qd$1@cesium.transmeta.com>
	<20020820180956.L21269@redhat.com>
X-Mailer: VM 6.95 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Benjamin" == Benjamin LaHaise <bcrl@redhat.com> writes:

Benjamin> Is there an autofs v4 daemon that's actually released?  The
Benjamin> only thing I see is code that's over a year old in
Benjamin> /pub/linux/daemons/autofs/testing-v4/ on kernel.org.  If
Benjamin> pre10 is okay, it should be released (at least that would
Benjamin> explain why we're still shipping v3).

Well, HPA says that pre10 has some serious problems, but it was the
only version I could get to work with our Solaris NIS environment and
out NetApps reliably.  I'd release the darn thing and let people send
in patches as needed.

John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-399-0479

