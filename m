Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289703AbSAOWor>; Tue, 15 Jan 2002 17:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289708AbSAOWoi>; Tue, 15 Jan 2002 17:44:38 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:40067
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289703AbSAOWoc>; Tue, 15 Jan 2002 17:44:32 -0500
Date: Tue, 15 Jan 2002 17:28:13 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: James Antill <james@and.org>
Cc: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Penelope builds a kernel
Message-ID: <20020115172813.A10210@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	James Antill <james@and.org>, Benjamin LaHaise <bcrl@redhat.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020114165909.A20808@thyrsus.com> <20020114173542.C30639@redhat.com> <20020114173854.C23081@thyrsus.com> <20020114180007.D30639@redhat.com> <20020114180522.A24120@thyrsus.com> <20020114183820.G30639@redhat.com> <20020114205307.E24120@thyrsus.com> <nn1ygrw8h1.fsf@code.and.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <nn1ygrw8h1.fsf@code.and.org>; from james@and.org on Tue, Jan 15, 2002 at 05:32:58PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Antill <james@and.org>:
> . User runs fetchmail
> . fetchmail feeds email to exim
> . exim does callback verification, and refuses email.
> . fetchmail pretends it has delivered email, so _even if_ you hack your
>   MTA to say don't verify from localhost lost emails will never be
>   delivered by fetchmail (even though they are still on the server,
>   and fetchmail knew they didn't get sent).

If you tell fetchmail's config about exim's antispam responses 
correctly, this should not happen.

I have a lot of happy exim users on my development list.  Perhaps
you should try asking questions there?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"They that can give up essential liberty to obtain a little temporary 
safety deserve neither liberty nor safety."
	-- Benjamin Franklin, Historical Review of Pennsylvania, 1759.
