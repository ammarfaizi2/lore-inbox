Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263359AbTJQJpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 05:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263363AbTJQJpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 05:45:07 -0400
Received: from gprs147-144.eurotel.cz ([160.218.147.144]:57984 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263359AbTJQJpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 05:45:04 -0400
Date: Fri, 17 Oct 2003 11:44:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031017094443.GA7738@elf.ucw.cz>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <20031016230448.GA29279@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031016230448.GA29279@pegasys.ws>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Several months ago we encountered the hash collision problem
> with rsync.  This brought about a fair amount of discussion

So you found collision in something like md5 or sha1?

							Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
