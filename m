Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbUKREzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbUKREzQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 23:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbUKREzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 23:55:16 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:61111 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262552AbUKREyW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 23:54:22 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: GPL version, "at your option"?
Date: Wed, 17 Nov 2004 23:54:19 -0500
User-Agent: KMail/1.6.2
Cc: clemens@endorphin.org, davids@webmaster.com, linux-kernel@vger.kernel.org
References: <MDEHLPKNGKAHNMBLJOLKEEOHPNAA.davids@webmaster.com> <200411172150.40799.dtor_core@ameritech.net> <81348C10-390F-11D9-85DC-000393ACC76E@mac.com>
In-Reply-To: <81348C10-390F-11D9-85DC-000393ACC76E@mac.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200411172354.19223.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 November 2004 10:11 pm, Kyle Moffett wrote:
> What about section 2, subsection B of the GPL:
> > b) You must cause any work that you distribute or publish, that in
> >     whole or in part contains or is derived from the Program or any
> >     part thereof, to be licensed as a whole at no charge to all third
> >     parties under the terms of this License.
> 
> "this License", would refer to the specific version of the license.  
> This means
> that since the original code is dual-licensed under both versions, any 
> code
> that is a derivative work must _also_ be dual-licensed

No, not at all. I need only _one_ license to use the code. If original
code was dual-licensed, let's say GPL/BSD, I can chose to completely
ignore GPL part and treat the code as if it was always released BSD only.
Why do you think several components, like ACPI, are dual-licensed?
Intel chose to do that so they can take ACPI interpreter implementation
and use it somewhere else, in non-GPL environment.

Q9. Under what licensing is the source released?
A9. ACPI CA can be licensed under the GNU General Public License or via a
    separate license that may be more favorable to commercial OSVs. Please
    see the source code license header for specifics.

> (This assumes of course that the other license has a similar clause).
> In any case, any  work
> derived from a GPLv2'ed work must also be licensable under the GPLv2.
> Therefore, my request for _your_ source-code under the GPLv2 is 
> perfectly
> valid.

See above. For me it was never GPLv2, if was BSD all the way and my new
code I can chose to make BSD only. 

-- 
Dmitry
