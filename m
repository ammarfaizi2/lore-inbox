Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276448AbRJPRjL>; Tue, 16 Oct 2001 13:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276511AbRJPRjA>; Tue, 16 Oct 2001 13:39:00 -0400
Received: from [209.195.52.30] ([209.195.52.30]:36123 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S276448AbRJPRit>;
	Tue, 16 Oct 2001 13:38:49 -0400
From: David Lang <david.lang@digitalinsight.com>
To: John Levon <moz@compsoc.man.ac.uk>
Cc: linux-kernel@vger.kernel.org
Date: Tue, 16 Oct 2001 09:17:48 -0700 (PDT)
Subject: Re: VM
In-Reply-To: <20011016132851.B74778@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.40.0110160912250.6108-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not doing a comparison of the VM in 2.4.5 and the newer kernels, I'm
saying that based on the reports I have been seeing here I have not been
willing to risk moving to a newer kernel becouse I couldn't trust the VM
not to give me problems on my production boxes. the 2.4.5 has it's
problems, but they are survivable (except on one box which I had to
remove)

it's not a direct comparison of the kernels, it's a matter of being able
to trust that the new kernel won't hang me out to dry under load. (and I
am one of the many people out here who doesn't have the ability to
simulate the load before going into production)

David Lang


 On Tue, 16 Oct 2001, John Levon wrote:

> Date: Tue, 16 Oct 2001 13:28:51 +0100
> From: John Levon <moz@compsoc.man.ac.uk>
> To: linux-kernel@vger.kernel.org
> Subject: Re: VM
>
> On Mon, Oct 15, 2001 at 05:53:32PM -0700, David Lang wrote:
>
> > before switching my production machines from 2.4.5 to a newer kernel.
>
> running such an old kernel does not give a fair comparison. Personally I've
> found the /current/ ac VM to be stable and give slightly smoother feel than
> the linus tree VM.
>
> regards
> john
>
> --
> "I hear you have four hundred and eighty six PCs for sale ?"
> 	- Some Fool
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
