Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpNlXC6KqzrGjT22dBDgvyzC4rg==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Mon, 05 Jan 2004 21:40:31 +0000
Message-ID: <03b001c415a4$d95c6f30$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Date: Mon, 29 Mar 2004 16:45:23 +0100
To: <Administrator@osdl.org>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
        <mbligh@aracnet.com>
Subject: Re: [PATCH] Simplify node/zone field in page->flags
Mail-Followup-To: Matthew Dobson <colpatch@us.ibm.com>,Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,mbligh@aracnet.com
References: <3FE74B43.7010407@us.ibm.com> <20031222131126.66bef9a2.akpm@osdl.org> <3FF9D5B1.3080609@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3FF9D5B1.3080609@us.ibm.com>
User-Agent: Mutt/1.5.4i
From: "Jesse Barnes" <jbarnes@sgi.com>
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:45:25.0218 (UTC) FILETIME=[DA295C20:01C415A4]

On Mon, Jan 05, 2004 at 01:22:57PM -0800, Matthew Dobson wrote:
> Jesse had acked the patch in an earlier itteration.  The only thing 
> that's changed is some line offsets whilst porting the patch forward.
> 
> Jesse (or anyone else?), any objections to this patch as a superset of 
> yours?

No objections here.  Of course, you'll have to rediff against the
current tree since that stuff has been merged for awhile now.  On a
somewhat related note, Martin mentioned that he'd like to get rid of
memblks.  I'm all for that too; they just seem to get in the way.

Jesse
