Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWAZTeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWAZTeW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWAZTeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:34:21 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:16392 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751368AbWAZTeU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:34:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Cp5TEiZP3vgbfTOut1BtuqrE6G87bSu3A4+nW4J3udzJQHLwIUh9VzvxL8e68sIrlGllF75vWzgfVOzVOJwWkRjcp/r7Mqyzui6HbJUyjsqqXgxbTGGYUmVvfzztdzWPcmwMKE5h0yMOifdwIJNSppWWla31y6iAVwhRT4j+rZY=
Date: Thu, 26 Jan 2006 20:33:36 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Chase Venters <chase.venters@clientec.com>
Cc: paul@clubi.ie, torvalds@osdl.org, chase.venters@clientec.com,
       linux-os@analogic.com, mrmacman_g4@mac.com, marc@perkel.com,
       jmerkey@wolfmountaingroup.com, pmclean@cs.ubishops.ca,
       shemminger@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
Message-Id: <20060126203336.abd85065.diegocg@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0601261255430.17225@turbotaz.ourhouse>
References: <43D114A8.4030900@wolfmountaingroup.com>
	<20060120111103.2ee5b531@dxpl.pdx.osdl.net>
	<43D13B2A.6020504@cs.ubishops.ca>
	<43D7C780.6080000@perkel.com>
	<43D7B20D.7040203@wolfmountaingroup.com>
	<43D7B5C4.5040601@wolfmountaingroup.com>
	<43D7D05D.7030101@perkel.com>
	<D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>
	<Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>
	<Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>
	<Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>
	<Pine.LNX.4.64.0601261757320.3920@sheen.jakma.org>
	<20060126195323.d553a4b8.diegocg@gmail.com>
	<Pine.LNX.4.64.0601261255430.17225@turbotaz.ourhouse>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 26 Jan 2006 12:57:27 -0600 (CST),
Chase Venters <chase.venters@clientec.com> escribió:

> So the question is - why would the GPL need a clause that says "You can 
> use any version of the GPL if the Program does not specify a version" when 
> every official version of the GPL includes a version number? Are they 
> expecting authors to strip the version number header in order to somehow 
> take advantage of section 9?

That's what I though. The only sane reason I can find is that many
projects don't even include a copy of the GPL and just say "this
is licensed under the GNU Public License"
