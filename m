Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWDCQgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWDCQgE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWDCQgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:36:04 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:35230 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S1751067AbWDCQgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:36:03 -0400
Date: Mon, 3 Apr 2006 18:35:41 +0200
From: Frank Gevaerts <frank@gevaerts.be>
To: Jean Delvare <khali@linux-fr.org>
Cc: Frank Gevaerts <frank@gevaerts.be>, Robert Love <rlove@rlove.org>,
       linux-kernel@vger.kernel.org
Subject: Re: patch : hdaps on Thinkpad R52
Message-ID: <20060403163541.GA4571@gevaerts.be>
Mail-Followup-To: Jean Delvare <khali@linux-fr.org>,
	Frank Gevaerts <frank@gevaerts.be>, Robert Love <rlove@rlove.org>,
	linux-kernel@vger.kernel.org
References: <20060314205758.GA9229@gevaerts.be> <20060328182933.4184db3f.khali@linux-fr.org> <20060328170045.GA10334@gevaerts.be> <20060401170422.cc2ff8c2.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060401170422.cc2ff8c2.khali@linux-fr.org>
X-flash-is-evil: do not use it
X-virus: If this mail contains a virus, feel free to send one back
User-Agent: Mutt/1.5.9i
X-gevaerts-MailScanner: Found to be clean
X-MailScanner-From: fg@gevaerts.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2006 at 05:04:22PM +0200, Jean Delvare wrote:
> Hi Frank,
> 
> > # dmidecode 2.8
> > (...)
> > System Information
> > 	Manufacturer: IBM
> > 	Product Name: 1846AQG
> > 	Version: ThinkPad H   
> 
> OK, so as strange as it sounds, that's really the string as stored in
> the DMI table. How odd... You have to understand that I'm a bit
> reluctant to adding it officially to the hdaps driver, given that it
> clearly looks like a bogus table in your laptop. I guess that you only
> have one laptop with this string?

I just had a mail from another R52 user, reporting that his system
(also 1846AQG) also reports ThinkPad H.

Frank

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
