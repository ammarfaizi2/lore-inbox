Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVBOQVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVBOQVV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 11:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVBOQTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 11:19:12 -0500
Received: from upco.es ([130.206.70.227]:30443 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261773AbVBOQOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 11:14:17 -0500
Date: Tue, 15 Feb 2005 17:14:12 +0100
From: Romano Giannetti <romanol@upco.es>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Stelian Pop <stelian@popies.net>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Message-ID: <20050215161412.GC20951@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romanol@upco.es>,
	Vojtech Pavlik <vojtech@suse.cz>, Stelian Pop <stelian@popies.net>,
	Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
	linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <20050210161809.GK3493@crusoe.alcove-fr> <E1D0dqo-00041G-00@chiark.greenend.org.uk> <20050214105837.GE3233@crusoe.alcove-fr> <20050214203211.GA8007@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20050214203211.GA8007@ucw.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 09:32:11PM +0100, Vojtech Pavlik wrote:
>  
> Yes, I'd like to see that. The other possible way is have the input
> layer generate ACPI events for power-related keys.
> 

I beg your pardon, but I have a very strange problem with ACPI event on a
Sony laptop. Probably it's completely unraleted, but if you have time to
have a look, it is on bugzilla too:

http://bugme.osdl.org/show_bug.cgi?id=4124

Thanks! 
        Romano

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
